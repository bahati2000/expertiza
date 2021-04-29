describe MentorManagement do
  describe '#select_mentor' do
    it 'returns the mentor with the fewest teams they mentor' do
      assignment = FactoryBot.build(:assignment)
      mentor = FactoryBot.build(:participant, duty: Participant::DUTY_MENTOR, user_id: 1)
      allow(MentorManagement).to receive(:zip_mentors_with_team_count)
              .with(assignment.id)
              .and_return([mentor.id, 0])
      allow(User).to receive(:where).with(id: mentor.id).and_return([mentor])
      mentor_user = MentorManagement.select_mentor assignment.id
      expect(mentor_user).to eq(mentor)
    end
  end

  describe '#update_mentor_state' do
    it 'assigns a mentor to a team when the team size passes 50% max capacity' do

    end
  end

  describe '#user_a_mentor?' do
    it 'should return true if user is a mentor' do
      non_mentor = FactoryBot.create(:participant)
      expect(MentorManagement.user_a_mentor?(non_mentor)).to be false
      mentor = FactoryBot.create(:participant, duty: Participant::DUTY_MENTOR)
      user = FactoryBot.build(:teaching_assistant, id: mentor.user_id)
      expect(MentorManagement.user_a_mentor?(user)).to be true
    end
  end

  describe '#get_mentors_for_assignment' do
    it 'returns all mentors for the given assignment' do
      mentor = FactoryBot.build(:participant, id: 998, user_id: 999, duty: Participant::DUTY_MENTOR)
      assignment = FactoryBot.build(:assignment)
      allow(Participant).to receive(:where)
                              .with(parent_id: assignment.id, duty: Participant::DUTY_MENTOR)
                              .and_return([mentor])
      mentor_user = MentorManagement.get_mentors_for_assignment(assignment.id).first
      expect(mentor_user).to eq(mentor)
    end
  end

  describe '#zip_mentors_with_team_count' do
    it 'returns sorted tuples of (mentor ID, # of teams they mentor)' do

    end
  end
end