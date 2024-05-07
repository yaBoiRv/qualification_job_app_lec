# frozen_string_literal: true

module ApplicationHelper
  def active_class(link_path)
    current_path = request.path
    provided_path = URI.parse(link_path).path
    current_path == provided_path ? 'active' : ''
  end

  def pending_associations_count(user)
    return unless user_signed_in?

    user.pending_associations.where(status: 'pending').count
  end
end
