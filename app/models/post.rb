require File.dirname( __FILE__ ) + '/../helpers/application_helper'

class Post < ActiveRecord::Base

  include ApplicationHelper

  belongs_to :user
  belongs_to :list  
  validates_presence_of :user
  validates_presence_of :list
  validates_length_of :title, :within => 1..TITLE_LENGTH

  def post # If this post has a parent post, it is a comment on that post
    (post_id.nil?? nil : Post.find( post_id ))
  end

  def length
    return '' if height.nil?
    return (height.to_f / 3.to_f).to_i.to_s
  end
                                                                                  
  def picture
    return '' if image.nil?
    return "<img src='/data/"  + image + \
            "' width='" + width.to_s + "' height='" + height.to_s + "' />"
  end
  
  def url_title
    'posts/' + title.gsub( TITLE_REG, '-' ).downcase + '-' + user.post_display    
  end  
  
  def self.per_page
    NUM_PER_PAGE # Used by will_paginate to decide how many to show per page
  end
  
  def date_display
    d = date_string(created_at)
  end

  def message=(msg)   
    write_attribute( :message, link(msg) )
  end

  def short
    massage_message(MSG_MIN, MSG_MED)
  end
  
  def long
    massage_message(nil, nil)
  end
  
  def massage_message(min, max)
    msg = message.gsub(/<[^>]*>/, '')
    msg = msg.gsub(/\&.*\;/, '      ')
    msg = msg.gsub(/\n/, '  ')
    return msg if min.nil? or max.nil?
    return msg if message.size < min
    msg = msg[0..max]
    msg = msg + "..." if message.size > 1 + max
    msg  
  end

  def email_display
    return '' if user.nil? 
    return '' if user.guest?
    return '' if user.admin?
    'by ' + user.name_display
  end

 private 

 require File.dirname( __FILE__ ) + '/../helpers/url_helper'
 include UrlHelper

end


