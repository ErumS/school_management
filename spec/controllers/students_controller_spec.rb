require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  context 'Success' do
    
    context 'GET index' do
      it 'should show all students successfully' do
        student1 = FactoryGirl.create(:student, phone_no:"545665332234")
        student2 = FactoryGirl.create(:student, phone_no:"545665332234")
        get :index, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'GET show' do
      it 'should show student with given id successfully' do
        student = FactoryGirl.create(:student, phone_no:"545665332234")
        get :show, id: student.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'POST create' do
      it 'should be a valid student creation' do
        student = FactoryGirl.create(:student, phone_no:"44556677888")
        post :create, student: {name: student.name, address: student.address, phone_no: student.phone_no},format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid student creation' do
        student = FactoryGirl.create(:student, phone_no:"44556677888")
        post :create, student: {name: student.name, address: "India", phone_no: student.phone_no},format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'PUT update' do
      it 'should be a valid student updation' do
        student = FactoryGirl.create(:student, phone_no:"44556677888")
        put :update, id:student.id, student: {name: "Nia", address:student.address, phone_no:student.phone_no}, format: 'json'
        response.should have_http_status(:ok)
      end
      it 'should be a valid student updation' do
        student = FactoryGirl.create(:student, phone_no:"44556677888")
        put :update, id:student.id, student: {name: "Nia", address:"India", phone_no:student.phone_no}, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'DELETE destroy' do
      it 'should be a valid student deletion' do
        student = FactoryGirl.create(:student, phone_no:"44556677888")
        delete :destroy, id:student.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
  end

  context'Failure' do

    context 'GET show' do
      it 'should not show a valid student' do
        student = FactoryGirl.create(:student, phone_no:"44556677888")
        get :show, id:33, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
    context 'POST create' do
      it 'should not create a student with invalid input' do
        student = FactoryGirl.create(:student, phone_no:"44556677888")
        post :create, student: {name: student.name, address: student.address, phone_no:"1346"},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a student with nil entries' do
        student = FactoryGirl.create(:student, phone_no:"44556677888")
        post :create, student: {name: nil, address: student.address, phone_no:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a student with invalid school id' do
        student = FactoryGirl.create(:student)
        post :create, student: {school_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a student with invalid classroom id' do
        student = FactoryGirl.create(:student)
        post :create, student: {classroom_id:nil},format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end
    end
    context 'PUT update' do
      it 'should not be a valid student updation with invalid id' do
        student = FactoryGirl.create(:student, phone_no:"44556677888")
        put :update, id:111, student: {name: "abc", address:student.address, phone_no:student.phone_no}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not be a valid student updation with invalid input' do
        student = FactoryGirl.create(:student, phone_no:"44556677888")
        put :update, id:student.id, student: {name: "abc", address:student.address, phone_no:nil}, format: 'json'
        response.should have_http_status(:unprocessable_entity)
      end 
      it 'should not be a valid student updation with invalid school id' do
        student = FactoryGirl.create(:student)
        put :update, id:student.id, student: {standard:"VI", school_id:55555}, format: 'json'
        response.should have_http_status(:not_found)
      end 
      it 'should not be a valid student updation with invalid classroom id' do
        student = FactoryGirl.create(:student)
        put :update, id:student.id, student: {standard:"VI", classroom_id:55555}, format: 'json'
        response.should have_http_status(:not_found)
      end 
    end 
    context 'DELETE destroy' do
      it 'should not be a valid student deletion with invalid id' do
        student = FactoryGirl.create(:student, phone_no:"44556677888")
        delete :destroy, id:123, format: 'json'
        response.should have_http_status(:not_found)
      end
    end
  end
end