require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Relationships' do
    it { is_expected.to have_many(:accounts) }
  end
end
