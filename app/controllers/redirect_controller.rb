class RedirectController < ApplicationController

  def redirect
    params[:p].blank? and raise ActionController::RoutingError, 'Not Found'

    logger.debug "************ figuring out where to redirect #{params[:p]} to..."

    # looking for category?
    if params[:p] =~ /\A\/categories\/(\w+)/
      logger.debug "************ a category!"
      category_name = $1
      category = Category.find_by_name(category_name)
      if !category.blank?
        logger.debug "************ redirecting to #{category.name}..."
        return redirect_to category_path(category), status: :moved_permanently
      else
        logger.debug "************ but no category called '#{category_name}' was found..."
        raise ActionController::RoutingError, 'Not Found'
      end
    end

    # looking for discussion?
    if params[:p] =~ /\A\/discussion\/([0-9]+)\//
      logger.debug "************ a discussion!"
      discussion_id = $1
      discussion = Discussion.where('DiscussionID = ?', discussion_id).first
      if !discussion.blank?
        logger.debug "************ redirecting to #{discussion.name}..."
        return redirect_to discussion_path(discussion), status: :moved_permanently
      else
        logger.debug "************ but no discussion with id '#{discussion_id}' was found..."
        raise ActionController::RoutingError, 'Not Found'
      end
    end

    # looking for user profile?
    if params[:p] =~ /\A\/profile\/(\w+)/
      logger.debug "************ a user profile!"
      user_name = $1
      user = User.find_by_name(user_name)
      if !user.blank?
        logger.debug "************ redirecting to #{user.name}..."
        return redirect_to user_path(user), status: :moved_permanently
      else
        logger.debug "************ but no user called '#{user_name}' was found..."
        raise ActionController::RoutingError, 'Not Found'
      end
    end


    logger.warn "************ didn't understand how to redirect #{params[:p]} :("
    raise ActionController::RoutingError, 'Not Found'
  end

end
