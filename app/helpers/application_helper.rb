module ApplicationHelper

  # if a date is in the past year, display as 'Month Day', otherwise, display
  # as 'Month Year'
  def date_disp(date)
    if date > Date.today-1.year
      date.to_formatted_s(:month_day)
    else
      date.to_formatted_s(:month_year)
    end
  end

  def user_avatar_link_unless_private(user)
    if user.blank?
      image_tag("https://api.dicebear.com/8.x/bottts/png/seed=unknown&rotate=180&baseColor=aaaaaa&eyes=dizzy&face=square01&mouth=grill03&sides=square&topProbability=0", alt: 'unknown', title: 'unknown', width: 40, height: 40, loading: 'lazy')
    else
      image = image_tag(user.photo_url, alt: user.name, title: user.name, width: 40, height: 40, loading: 'lazy')
      if user.deleted? || user.private?
        image
      else
        link_to image, user_path(user.id)
      end
    end
  end

  def user_link_unless_private(user)
    if user.blank?
      'unknown'
    else
      if user.deleted? || user.private?
        user.name
      else
        link_to user.name, user_path(user.id)
      end
    end
  end

end
