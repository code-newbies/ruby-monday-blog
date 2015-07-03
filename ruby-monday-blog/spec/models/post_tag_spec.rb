require 'rails_helper'

describe PostTag do
    it {should belong_to(:tag)}
    it {should belong_to(:post)}
end
