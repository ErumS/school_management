require 'rails_helper'

RSpec.describe Student, type: :model do
  context 'Validations' do

    context 'Success' do
      it 'should be a valid student' do
        FactoryGirl.build(:student, name:"Inox", address:"University", phone_no:"444444443", percentage:55.90).should be_valid
      end
      it 'should be a valid student' do
        FactoryGirl.build(:student, phone_no:"5588745437895").should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid student' do
        FactoryGirl.build(:student, name:"Inox", address:"University", phone_no: "44434").should_not be_valid
      end
      it 'should not be a valid student' do
        FactoryGirl.build(:student, phone_no: "44434678783487387874755").should_not be_valid
      end
      it 'should not be a valid student' do
        FactoryGirl.build(:student, address: nil).should_not be_valid
      end  
      it 'should not be a valid student' do
        FactoryGirl.build(:student, name:nil).should_not be_valid
      end 
      it 'should not be a valid student' do
        FactoryGirl.build(:student, phone_no: nil).should_not be_valid
      end 
      it 'should not be a valid student' do
        FactoryGirl.build(:student, address:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid student' do
        FactoryGirl.build(:student, name:nil, address:nil).should_not be_valid
      end
      it 'should not be a valid student' do
        FactoryGirl.build(:student, name:nil, phone_no:nil).should_not be_valid
      end 
      it 'should not be a valid student' do
        FactoryGirl.build(:student, name:nil, address:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid student' do
        FactoryGirl.build(:student, phone_no:454545).should_not be_valid
      end
    end
  end

  context 'Associations' do

    context 'Success' do
      it 'should belongs to school' do
        school = FactoryGirl.create(:school, phone_no:"3344556677")
        student = FactoryGirl.create(:student, school_id:school.id)
        student.school.id.should eq school.id
      end
      it 'should belongs to classroom' do
        classroom = FactoryGirl.create(:classroom)
        student = FactoryGirl.create(:student, classroom_id:classroom.id)
        student.classroom.id.should eq classroom.id
      end
      it 'should have many subjects' do
        student = FactoryGirl.create(:student, phone_no:"467574378")
        subject1 = FactoryGirl.create(:subject, student_ids:student.id)
        subject2 = FactoryGirl.create(:subject, student_ids:student.id)
        student.subjects.should include subject1
        student.subjects.should include subject2    
      end
      it 'should have many teachers' do
        student = FactoryGirl.create(:student, phone_no:"467574378")
        teacher1 = FactoryGirl.create(:teacher, student_ids:student.id)
        teacher2 = FactoryGirl.create(:teacher, student_ids:student.id)
        student.teachers.should include teacher1
        student.teachers.should include teacher2    
      end
    end

    context 'Failure' do
      it 'should not belongs to school' do
        school1 = FactoryGirl.create(:school, phone_no:"3344556677")
        school2 = FactoryGirl.create(:school, phone_no:"3344556677")
        student1 = FactoryGirl.create(:student, school_id:school1.id)
        student2 = FactoryGirl.create(:student, school_id:school2.id)
        student1.school.id.should eq school1.id
        student1.school.id.should_not eq school2.id
        student2.school.id.should eq school2.id
        student2.school.id.should_not eq school1.id
      end
      it 'should not belongs to classroom' do
        classroom1 = FactoryGirl.create(:classroom)
        classroom2 = FactoryGirl.create(:classroom)
        student1 = FactoryGirl.create(:student, classroom_id:classroom1.id)
        student2 = FactoryGirl.create(:student, classroom_id:classroom2.id)
        student1.classroom.id.should eq classroom1.id
        student1.classroom.id.should_not eq classroom2.id
        student2.classroom.id.should eq classroom2.id
        student2.classroom.id.should_not eq classroom1.id
      end
      it 'should not have many subjects' do
        student = FactoryGirl.create(:student, phone_no:"467574378")
        subject1 = FactoryGirl.create(:subject)
        subject2 = FactoryGirl.create(:subject)
        student.subjects.should_not include subject1
        student.subjects.should_not include subject2 
      end
      it 'should not have many teachers' do
        student = FactoryGirl.create(:student, phone_no:"467574378")
        teacher1 = FactoryGirl.create(:teacher)
        teacher2 = FactoryGirl.create(:teacher)
        student.teachers.should_not include teacher1
        student.teachers.should_not include teacher2    
      end
    end
  end
end