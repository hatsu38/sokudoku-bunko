# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.create' do
    it '生成できる' do
      expect(create(:user).id).to be_present
    end
  end

  describe 'validation' do
    it 'validationが効いてること' do
      expect(create(:user)).to be_valid
    end

    describe 'email is nill' do
      let(:user) { build(:user, email: '') }
      it 'is not be valid without email' do
        expect(user).to be_invalid
      end
    end

    describe 'password is nill' do
      let(:user) { build(:user, password: '') }
      it 'is not be valid without password' do
        expect(user).to be_invalid
      end
    end
  end
end
