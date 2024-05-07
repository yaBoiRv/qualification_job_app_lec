# frozen_string_literal: true

require 'test_helper'

class PendingAssociationRequestsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get pending_association_requests_index_url
    assert_response :success
  end
end
