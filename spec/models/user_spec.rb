require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to have_many(:notes).dependent(:destroy) }
  it { is_expected.to belong_to(:user) }

end
