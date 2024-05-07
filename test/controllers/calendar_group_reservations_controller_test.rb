# frozen_string_literal: true

require 'test_helper'

class CalendarGroupReservationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get calendar_group_reservations_index_url
    assert_response :success
  end
end
