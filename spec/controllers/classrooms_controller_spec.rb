require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all classrooms successfully' do
        classroom1 = FactoryGirl.create(:classroom)
        classroom2 = FactoryGirl.create(:classroom)
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show classroom with given id successfully' do
        classroom = FactoryGirl.create(:classroom)
        get :show, id: classroom.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should be a valid classroom creation' do
        classroom = FactoryGirl.create(:classroom)
        post :create, classroom: {standard:classroom.standard, no_of_students:classroom.no_of_students, school_id:classroom.school_id},format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid classroom creation' do
        classroom = FactoryGirl.create(:classroom)
        post :create, classroom: {standard:"VII", no_of_students:classroom.no_of_students, school_id:classroom.school_id},format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should be a valid classroom updation' do
        classroom = FactoryGirl.create(:classroom)
        put :update, id:classroom.id, classroom: {standard:"VI", no_of_students:classroom.no_of_students, school_id:classroom.school_id}, format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid classroom updation' do
        classroom = FactoryGirl.create(:classroom)
        put :update, id:classroom.id, classroom: {standard:"VI", no_of_students:46, school_id:classroom.school_id}, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should be a valid classroom deletion' do
        classroom = FactoryGirl.create(:classroom)
        delete :destroy, id:classroom.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do
    
    context 'GET show' do
      it 'should not show a valid classroom' do
        classroom = FactoryGirl.create(:classroom)
        get :show, id:33, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a classroom with invalid input' do
        classroom = FactoryGirl.create(:classroom)
        post :create, classroom: {standard:classroom.standard, no_of_students:500},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a classroom with nil entries' do
        classroom = FactoryGirl.create(:classroom)
        post :create, classroom: {standard:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a classroom with invalid school id' do
        classroom = FactoryGirl.create(:classroom)
        post :create, classroom: {school_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not be a valid classroom updation with invalid id' do
        classroom = FactoryGirl.create(:classroom)
        put :update, id:111, classroom: {standard:classroom.standard, no_of_students:classroom.no_of_students}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not be a valid classroom updation with invalid input' do
        classroom = FactoryGirl.create(:classroom)
        put :update, id:classroom.id, classroom: {standard:classroom.standard, no_of_students:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
      it 'should not be a valid classroom updation with invalid school id' do
        classroom = FactoryGirl.create(:classroom)
        put :update, id:classroom.id, classroom: {standard:"VI", school_id:55555}, format: 'json'
        response.should have_http_status(:not_found )
      end 
    end 
    context 'DELETE destroy' do
      it 'should not be a valid classroom deletion with invalid id' do
        classroom = FactoryGirl.create(:classroom)
        delete :destroy, id:123, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end