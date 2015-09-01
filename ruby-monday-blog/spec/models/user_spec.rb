# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :integer
#  first_name             :string
#  last_name              :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:reader) { build(:reader) }
  let(:author) { build(:author) }
  let(:admin)  { build(:admin) }

  describe 'factories' do
    it 'should be valid' do
      expect(reader).to be_valid
      expect(author).to be_valid
      expect(admin).to be_valid
    end
  end

  describe 'validations' do
    context 'when user is an author' do
      it 'validates presence of first name and last name' do
        expect(author).to validate_presence_of(:first_name)
        expect(author).to validate_presence_of(:last_name)
      end
    end

    context 'when user is a reader' do
      it 'should not validate presence of names' do
        expect(reader).to_not validate_presence_of(:first_name)
        expect(reader).to_not validate_presence_of(:last_name)
      end
    end
  end
end
