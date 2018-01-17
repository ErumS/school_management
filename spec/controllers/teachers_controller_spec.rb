require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all teachers successfully' do
        teacher1 = FactoryGirl.create(:teacher)
        teacher2 = FactoryGirl.create(:teacher)
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show teacher with given id successfully' do
        teacher = FactoryGirl.create(:teacher)
        get :show, id: teacher.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should be a valid teacher creation' do
        teacher = FactoryGirl.create(:teacher)
        post :create, teacher: {name: teacher.name, subject_name:teacher.subject_name, salary:teacher.salary},format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid teacher creation' do
        teacher = FactoryGirl.create(:teacher)
        post :create, teacher: {name: teacher.name, subject_name:"History", salary:teacher.salary},format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should be a valid teacher updation' do
        teacher = FactoryGirl.create(:teacher)
        put :update, id:teacher.id, teacher: {name: "Nia", subject_name:teacher.subject_name, salary:teacher.salary}, format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid teacher updation' do
        teacher = FactoryGirl.create(:teacher)
        put :update, id:teacher.id, teacher: {name: "Nia", subject_name:teacher.subject_name, salary:45000}, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should be a valid teacher deletion' do
        teacher = FactoryGirl.create(:teacher)
        delete :destroy, id:teacher.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do

    context 'GET show' do
      it 'should not show a valid teacher' do
        teacher = FactoryGirl.create(:teacher)
        get :show, id:33, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a teacher with invalid input' do
        teacher = FactoryGirl.create(:teacher)
        post :create, teacher: {name: teacher.name, subject_name:teacher.subject_name, salary:10}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a teacher with nil entries' do
        teacher = FactoryGirl.create(:teacher)
        post :create, teacher: {name: nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a teacher with invalid school id' do
        teacher = FactoryGirl.create(:teacher)
        post :create, teacher: {school_id:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a teacher with invalid subject id' do
        teacher = FactoryGirl.create(:teacher)
        post :create, teacher: {subject_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not be a valid teacher updation with invalid id' do
        teacher = FactoryGirl.create(:teacher)
        put :update, id:111, teacher: {name: "abc", subject_name:teacher.subject_name, salary:teacher.salary}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not be a valid teacher updation with invalid input' do
        teacher = FactoryGirl.create(:teacher)
        put :update, id:teacher.id, teacher: {name: "abc", subject_name:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
      it 'should not be a valid teacher updation with invalid school id' do
        teacher = FactoryGirl.create(:teacher)
        put :update, id:teacher.id, teacher: {name:"abc", school_id:55555}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not be a valid teacher updation with invalid subject id' do
        teacher = FactoryGirl.create(:teacher)
        put :update, id:teacher.id, teacher: {name:"abc", subject_id:55555}, format: 'json'
        response.should have_http_status(:not_found)
      end 
    end 
    context 'DELETE destroy' do
      it 'should not be a valid teacher deletion with invalid id' do
        teacher = FactoryGirl.create(:teacher)
        delete :destroy, id:123, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end