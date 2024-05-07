# frozen_string_literal: true

class PendingAssociationsController < ApplicationController
  def accept
    pending_association = PendingAssociation.find(params[:id])

    if pending_association.update(status: 'accepted')
      pending_association.calendar_group.users << pending_association.user
      pending_association.destroy
      redirect_to profile_path, notice: 'Veiksmīgi pievienots kalendāram'
    else
      redirect_to profile_path, alert: 'Notika kļūda'
    end
  end

  def reject
    pending_association = PendingAssociation.find(params[:id])

    if pending_association.destroy
      redirect_to profile_path, notice: 'Veiksmīgi atteicāties no pievienošanas kalendāram'
    else
      redirect_to profile_path, alert: 'Notika kļūda'
    end
  end
end
