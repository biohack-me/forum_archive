class RedirectController < ApplicationController

  def redirect

    # cache each set of params so we only do the logic once
    redirect_action = Rails.cache.fetch("redirect_for_#{params[:p]}") do
      redirect_path = false
      not_found = false

      params[:p].blank? and not_found = true

      logger.debug "************ figuring out where to redirect #{params[:p]} to..."

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
        discussion = comment.discussion
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
