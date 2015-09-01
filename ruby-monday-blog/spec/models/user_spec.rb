require 'rails_helper'

RSpec.describe User, type: :model do
  let(:author) { User.new(first_name: 'First', last_name: 'Last', email: 'test@example.com', password: 'password', role: :author) }
  let(:reader) { User.new(first_name: nil, last_name: nil, email: 'test@example.com', password: 'password', role: :reader) }

  describe 'validations' do
    context 'when user is an author' do
      it 'validates presence of first name and last name' do
        expect(author).to be_valid
      end
    end

    context 'when user is a reader' do
      it 'should not validate presence of names' do
        expect(reader).to be_valid
      end
    end
  end
end
