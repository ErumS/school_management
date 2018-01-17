require 'rails_helper'

RSpec.describe School, type: :model do
  context 'Validations' do

    context 'Success' do
      it 'should be a valid school' do
        FactoryGirl.build(:school, name:"Inox", address:"University", phone_no:"444444443").should be_valid
      end
      it 'should be a valid school' do
        FactoryGirl.build(:school, phone_no:"5588745437895").should be_valid
      end
    end

    context 'Failure' do
      it 'should not be a valid school' do
        FactoryGirl.build(:school, name:"Inox", address:"University", phone_no: "44434").should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, phone_no: "44434678783487387874755").should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, address: nil).should_not be_valid
      end  
      it 'should not be a valid school' do
        FactoryGirl.build(:school, name:nil).should_not be_valid
      end 
      it 'should not be a valid school' do
        FactoryGirl.build(:school, phone_no: nil).should_not be_valid
      end 
      it 'should not be a valid school' do
        FactoryGirl.build(:school, address:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, name:nil, address:nil).should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, name:nil, phone_no:nil).should_not be_valid
      end 
      it 'should not be a valid school' do
        FactoryGirl.build(:school, name:nil, address:nil, phone_no:nil).should_not be_valid
      end
      it 'should not be a valid school' do
        FactoryGirl.build(:school, phone_no:454545).should_not be_valid
      end
    end
  end

  context 'Associations' do

    context 'Success' do
      it 'should have many classrooms' do
        school = FactoryGirl.create(:school, phone_no:"467574378")
        classroom1 = FactoryGirl.create(:classroom, school_id:school.id)
        classroom2 = FactoryGirl.create(:classroom, school_id:school.id)
        school.classrooms.should include classroom1
        school.classrooms.should include classroom2 
      end
      it 'should have many students' do
        school = FactoryGirl.create(:school, phone_no:"467574378")
        student1 = FactoryGirl.create(:student, school_id:school.id)
        student2 = FactoryGirl.create(:student, school_id:school.id)
        school.students.should include student1
        school.students.should include student2
      end
      it 'should have many subjects' do
        school = FactoryGirl.create(:school, phone_no:"467574378")
        subject1 = FactoryGirl.create(:subject, school_id:school.id)
        subject2 = FactoryGirl.create(:subject, school_id:school.id)
        school.subjects.should include subject1
        school.subjects.should include subject2    
      end
      it 'should have many teachers' do
        school = FactoryGirl.create(:school, phone_no:"467574378")
        teacher1 = FactoryGirl.create(:teacher, school_id:school.id)
        teacher2 = FactoryGirl.create(:teacher, school_id:school.id)
        school.teachers.should include teacher1
        school.teachers.should include teacher2    
      end
    end

    context 'Failure' do
      it 'should not have many classrooms' do
        school = FactoryGirl.create(:school, phone_no:"467574378")
        classroom1 = FactoryGirl.create(:classroom)
        classroom2 = FactoryGirl.create(:classroom)
        school.classrooms.should_not include classroom1
        school.classrooms.should_not include classroom2 
      end
      it 'should not have many students' do
        school = FactoryGirl.create(:school, phone_no:"467574378")
        student1 = FactoryGirl.create(:student)
        student2 = FactoryGirl.create(:student)
        school.students.should_not include student1
        school.students.should_not include student2 
      end
      it 'should not have many subjects' do
        school = FactoryGirl.create(:school, phone_no:"467574378")
        subject1 = FactoryGirl.create(:subject)
        subject2 = FactoryGirl.create(:subject)
        school.subjects.should_not include subject1
        school.subjects.should_not include subject2 
      end
      it 'should not have many teachers' do
        school = FactoryGirl.create(:school, phone_no:"467574378")
        teacher1 = FactoryGirl.create(:teacher)
        teacher2 = FactoryGirl.create(:teacher)
        school.teachers.should_not include teacher1
        school.teachers.should_not include teacher2    
      end
    end
  end
end