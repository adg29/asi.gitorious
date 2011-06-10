require 'test_helper'

class ProposalUploadsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proposal_uploads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proposal_upload" do
    assert_difference('ProposalUpload.count') do
      post :create, :proposal_upload => { }
    end

    assert_redirected_to proposal_upload_path(assigns(:proposal_upload))
  end

  test "should show proposal_upload" do
    get :show, :id => proposal_uploads(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => proposal_uploads(:one).to_param
    assert_response :success
  end

  test "should update proposal_upload" do
    put :update, :id => proposal_uploads(:one).to_param, :proposal_upload => { }
    assert_redirected_to proposal_upload_path(assigns(:proposal_upload))
  end

  test "should destroy proposal_upload" do
    assert_difference('ProposalUpload.count', -1) do
      delete :destroy, :id => proposal_uploads(:one).to_param
    end

    assert_redirected_to proposal_uploads_path
  end
end
