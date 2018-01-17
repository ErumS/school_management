require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all schools successfully' do
        school1 = FactoryGirl.create(:school, phone_no:"545665332234")
        school2 = FactoryGirl.create(:school, phone_no:"545665332234")
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show school with given id successfully' do
        school = FactoryGirl.create(:school, phone_no:"545665332234")
        get :show, id: school.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should be a valid school creation' do
        school = FactoryGirl.create(:school, phone_no:"44556677888")
        post :create, school: {name: school.name, address: school.address, phone_no: school.phone_no}, format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid school creation' do
        school = FactoryGirl.create(:school, phone_no:"44556677888")
        post :create, school: {name: "high school", address: school.address, phone_no: school.phone_no}, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should be a valid school updation' do
        school = FactoryGirl.create(:school, phone_no:"44556677888")
        put :update, id:school.id, school: {name: "abc", address:school.address, phone_no:school.phone_no}, format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid school updation' do
        school = FactoryGirl.create(:school, phone_no:"44556677888")
        put :update, id:school.id, school: {name: "abc", address:school.address, phone_no:"5555555555"}, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should be a valid school deletion' do
        school = FactoryGirl.create(:school, phone_no:"44556677888")
        delete :destroy, id:school.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do

    context 'GET show' do
      it 'should not show a valid school' do
        school = FactoryGirl.create(:school, phone_no:"44556677888")
        get :show, id:33332, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a school with invalid input' do
        school = FactoryGirl.create(:school, phone_no:"44556677888")
        post :create, school: {name: school.name, address: school.address, phone_no:"1346"},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a school with nil entries' do
        school = FactoryGirl.create(:school, phone_no:"44556677888")
        post :create, school: {name: nil, address: school.address, phone_no:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not be a valid school updation with invalid id' do
        school = FactoryGirl.create(:school, phone_no:"44556677888")
        put :update, id:111, school: {name: "abc", address:school.address, phone_no:school.phone_no}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not be a valid school updation with invalid input' do
        school = FactoryGirl.create(:school, phone_no:"44556677888")
        put :update, id:school.id, school: {name: "abc", address:school.address, phone_no:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
    end 
    context 'DELETE destroy' do
      it 'should not be a valid school deletion with invalid id' do
        school = FactoryGirl.create(:school, phone_no:"44556677888")
        delete :destroy, id:123, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end