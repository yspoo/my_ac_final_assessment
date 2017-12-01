require 'rails_helper'

RSpec.describe Like, type: :model do

  # Associations
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:note) }

end
