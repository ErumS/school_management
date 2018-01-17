require 'rails_helper'

RSpec.describe Teacher, type: :model do
  context 'Validations' do

    context 'Success' do
      it 'should be a valid teacher' do
        FactoryGirl.build(:teacher, name:"Inox", subject_name:"Geography", salary:30000).should be_valid
      end
      it 'should be a valid teacher' do
        FactoryGirl.build(:teacher).should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid teacher' do
        FactoryGirl.build(:teacher, name:"Inox", subject_name:"Geography", salary:300).should_not be_valid
      end
      it 'should not be a valid teacher' do
        FactoryGirl.build(:teacher, salary:456788888).should_not be_valid
      end
      it 'should not be a valid teacher' do
        FactoryGirl.build(:teacher, name:nil).should_not be_valid
      end  
      it 'should not be a valid teacher' do
        FactoryGirl.build(:teacher, subject_name:nil).should_not be_valid
      end 
      it 'should not be a valid teacher' do
        FactoryGirl.build(:teacher, name:nil, subject_name:nil).should_not be_valid
      end
      it 'should not be a valid teacher' do
        FactoryGirl.build(:teacher, salary:"455677889").should_not be_valid
      end
    end
  end

  context 'Associations' do

    context 'Success' do
      it 'should belongs to school' do
        school = FactoryGirl.create(:school, phone_no:"3344556677")
        teacher = FactoryGirl.create(:teacher, school_id:school.id)
        teacher.school.id.should eq school.id
      end
      it 'should belongs to classroom' do
        classroom = FactoryGirl.create(:classroom)
        teacher = FactoryGirl.create(:teacher, classroom_id:classroom.id)
        teacher.classroom.id.should eq classroom.id
      end
      it 'should belongs to subject' do
        subject = FactoryGirl.create(:subject)
        teacher = FactoryGirl.create(:teacher, subject_id:subject.id)
        teacher.subject.id.should eq subject.id
      end
      it 'should have many students' do
        teacher = FactoryGirl.create(:teacher)
        student1 = FactoryGirl.create(:student, teacher_ids:teacher.id)
        student2 = FactoryGirl.create(:student, teacher_ids:teacher.id)
        teacher.students.should include student1
        teacher.students.should include student2
      end
    end

    context 'Failure' do
      it 'should not belongs to school' do
        school1 = FactoryGirl.create(:school, phone_no:"3344556677")
        school2 = FactoryGirl.create(:school, phone_no:"3344556677")
        teacher1 = FactoryGirl.create(:teacher, school_id:school1.id)
        teacher2 = FactoryGirl.create(:teacher, school_id:school2.id)
        teacher1.school.id.should eq school1.id
        teacher1.school.id.should_not eq school2.id
        teacher2.school.id.should eq school2.id
        teacher2.school.id.should_not eq school1.id
      end
      it 'should not belongs to classroom' do
        classroom1 = FactoryGirl.create(:classroom)
        classroom2 = FactoryGirl.create(:classroom)
        teacher1 = FactoryGirl.create(:teacher, classroom_id:classroom1.id)
        teacher2 = FactoryGirl.create(:teacher, classroom_id:classroom2.id)
        teacher1.classroom.id.should eq classroom1.id
        teacher1.classroom.id.should_not eq classroom2.id
        teacher2.classroom.id.should eq classroom2.id
        teacher2.classroom.id.should_not eq classroom1.id
      end
      it 'should not belongs to subject' do
        subject1 = FactoryGirl.create(:subject)
        subject2 = FactoryGirl.create(:subject)
        teacher1 = FactoryGirl.create(:teacher, subject_id:subject1.id)
        teacher2 = FactoryGirl.create(:teacher, subject_id:subject2.id)
        teacher1.subject.id.should eq subject1.id
        teacher1.subject.id.should_not eq subject2.id
        teacher2.subject.id.should eq subject2.id
        teacher2.subject.id.should_not eq subject1.id
      end
      it 'should not have many students' do
        teacher = FactoryGirl.create(:teacher)
        student1 = FactoryGirl.create(:student)
        student2 = FactoryGirl.create(:student)
        teacher.students.should_not include student1
        teacher.students.should_not include student2 
      end
    end
  end
end