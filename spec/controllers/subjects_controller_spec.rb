require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all subjects successfully' do
        subject1 = FactoryGirl.create(:subject)
        subject2 = FactoryGirl.create(:subject)
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show subject with given id successfully' do
        subject = FactoryGirl.create(:subject)
        get :show, id: subject.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should be a valid subject creation' do
        subject = FactoryGirl.create(:subject)
        post :create, subject: {name: subject.name, subject_duration:subject.subject_duration},format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid subject creation' do
        subject = FactoryGirl.create(:subject)
        post :create, subject: {name: subject.name, subject_duration:5},format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should be a valid subject updation' do
        subject = FactoryGirl.create(:subject)
        put :update, id:subject.id, subject: {name: "Nia", subject_duration:subject.subject_duration}, format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid subject updation' do
        subject = FactoryGirl.create(:subject)
        put :update, id:subject.id, subject: {name:subject.name, subject_duration:3}, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should be a valid subject deletion' do
        subject = FactoryGirl.create(:subject)
        delete :destroy, id:subject.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do

    context 'GET show' do
      it 'should not show a valid subject' do
        subject = FactoryGirl.create(:subject)
        get :show, id:33, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a subject with invalid input' do
        subject = FactoryGirl.create(:subject)
        post :create, subject: {name: subject.name, subject_duration:90}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a subject with nil entries' do
        subject = FactoryGirl.create(:subject)
        post :create, subject: {name: nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a subject with invalid school id' do
        subject = FactoryGirl.create(:subject)
        post :create, subject: {school_id:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a subject with invalid student id' do
        subject = FactoryGirl.create(:subject)
        post :create, subject: {student_ids:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not be a valid subject updation with invalid id' do
        subject = FactoryGirl.create(:subject)
        put :update, id:111, subject: {name: "abc", subject_duration:subject.subject_duration}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not be a valid subject updation with invalid input' do
        subject = FactoryGirl.create(:subject)
        put :update, id:subject.id, subject: {name: "abc", subject_duration:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
      it 'should not be a valid subject updation with invalid school id' do
        subject = FactoryGirl.create(:subject)
        put :update, id:subject.id, subject: {name:"abc", school_id:55555}, format: 'json'
        response.should have_http_status(:not_found)
      end 
    end 
    context 'DELETE destroy' do
      it 'should not be a valid subject deletion with invalid id' do
        subject = FactoryGirl.create(:subject)
        delete :destroy, id:123, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end