require 'rails_helper'

describe PostPolicy do
  let(:author) { build(:author) }
  let(:reader) { build(:reader) }
  let(:admin)  { build(:admin) }
  let(:post)   { build(:post, author: author) }

  subject { described_class }

  permissions '.scope' do
    it 'shows only published posts to regular readers'
    it 'shows unpublished posts (drafts) for authors'
    it 'shows all posts for admins'
  end

  permissions :show? do
    it 'grants access to a reader' do
      expect(subject).to permit(reader, post)
    end

    it 'grants access to a visitor (nil user)' do
      expect(subject).to permit(nil, post)
    end
  end

  permissions :create? do
    it 'grants access to an author' do
      expect(subject).to permit(author, post)
    end

    it 'prohibits access to a reader' do
      expect(subject).to_not permit(reader, post)
    end

    it 'grants access to an admin' do
      expect(subject).to permit(admin, post)
    end
  end

  permissions :update? do
    it 'grants access to a posts\' author' do
      expect(subject).to permit(author, post)
    end

    it 'prohibits access to a different author' do
      expect(subject).to_not permit(build(:author, first_name: 'other'), post)
    end

    it 'prohibits access to a reader' do
      expect(subject).to_not permit(reader, post)
    end

    it 'grants access to an admin' do
      expect(subject).to permit(admin, post)
    end
  end

  permissions :destroy? do
    it 'grants access to post\'s author' do
      expect(subject).to permit(author, post)
    end

    it 'prohibits access to a different author' do
      expect(subject).to_not permit(build(:author, first_name: 'other'), post)
    end

    it 'prohibits access to a reader' do
      expect(subject).to_not permit(reader, post)
    end

    it 'grants access to an admin' do
      expect(subject).to permit(admin, post)
    end
  end
end
