class RedirectController < ApplicationController

  def redirect
    logger.debug "************ figuring out where to redirect #{params[:p]} to..."
    redirect_path = false
    not_found = false

    # decide what we are caching outside the cached part, to cut down on
    # caching garbage and duplicate links
    if params[:p].blank?
      logger.debug "************* redirecting to nothing accomplished."
      not_found = true
      cache_path = '404'
    elsif ['/entry/register'].include?(params[:p])
      # checking params[:p] against an array so we can add additional redirect
      # paths to it if/when they surface
      logger.debug "************* redirecting from vanilla native redirect path..."

      if !params[:Target].blank?
        if (params[:Target] =~ /\Ahttps:\/\/forum.biohack.me\/index.php\?p=(.*)/) # it redirected to a whole ass URL
          target = $1
        elsif (params[:Target] =~ /\Ahttp/)
          logger.debug "************* calling shenanigans."
          not_found = true
          cache_path = '404'
        else
          target = '/'+params[:Target] 
        end
        if target
          logger.debug "************* redirecting to redirect link for #{target}..."
          return redirect_to redirect_path(p: target)
        end
      else
        logger.debug "************* but no target - redirecting to root"
        return redirect_to root_path
      end
    elsif params[:p] !~ /\A\/(categories|discussion|profile)\//
      logger.debug "************* not something we understand how to redirect to... likely shenanigans."
      not_found = true
      cache_path = '404'
    else
      logger.debug "************* passing on to cached redirect work..."
      cache_path = params[:p]
    end

    # cache each set of params so we only do the logic once
    redirect_action = Rails.cache.fetch("redirect_for_#{cache_path}") do

      # looking for category?
      if !not_found && (params[:p] =~ /\A\/categories\/(\w+)/)
        logger.debug "************ a category!"
        category_name = $1
        category = Category.find_by_name(category_name)
        if !category.blank?
          logger.debug "************ redirecting to #{category.name}..."
          redirect_path = category_path(category)
        else
          logger.debug "************ but no category called '#{category_name}' was found..."
          not_found = true
        end
      end

      # looking for discussion?
      if !not_found && (params[:p] =~ /\A\/discussion\/([0-9]+)\//)
        logger.debug "************ a discussion!"
        discussion_id = $1
        discussion = Discussion.where('DiscussionID = ?', discussion_id).first
        if !discussion.blank?
          logger.debug "************ redirecting to #{discussion.name}..."
          redirect_path = discussion_path(discussion)
        else
          logger.debug "************ but no discussion with id '#{discussion_id}' was found..."
          not_found = true
        end
      end

      # looking for comment?
      if !not_found && (params[:p] =~ /\A\/discussion\/comment\/([0-9]+)\/?/)
        logger.debug "************ a comment!"
        comment_id = $1
        comment = Comment.where('CommentID = ?', comment_id).first
        discussion = comment ? comment.discussion : nil
        if !comment.blank? && !discussion.blank?
          logger.debug "************ redirecting to #{discussion.name}..."
          comment_page = discussion.comment_page(comment_id)
          redirect_path = discussion_path(discussion, page: comment_page, anchor: comment_id)
        else
          logger.debug "************ but no discussion for comment with id '#{comment_id}' was found..."
          not_found = true
        end
      end

      # looking for user profile?
      if !not_found && (params[:p] =~ /\A\/profile\/(\w+)/)
        logger.debug "************ a user profile!"
        user_name = $1
        user = User.find_by_name(user_name)
        if !user.blank?
          logger.debug "************ redirecting to #{user.name}..."
          redirect_path = user_path(user)
        else
          logger.debug "************ but no user called '#{user_name}' was found..."
          not_found = true
        end
      end

      redirect_path ? redirect_path : false
    end

    if redirect_action
      return redirect_to redirect_action, status: :moved_permanently
    else
      raise ActionController::RoutingError, 'Not Found'
    end

  end

end
