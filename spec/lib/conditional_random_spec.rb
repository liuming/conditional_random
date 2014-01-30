require 'spec_helper'

describe ConditionalRandom do
  shared_examples "conditional random" do |method_name, condition|
    it "returns random matches the condition" do
      10.times do
        random = described_class.send(method_name, &condition)
        condition.call(random).should_not be_nil
      end
    end
  end

  describe :hex do
    subject { described_class.hex }
    it { should have_at_least(1).chars }
    it_behaves_like "conditional random", :hex, Proc.new{|random| random.match(/^[a-z]/) }
  end

  describe :base64 do
    subject { described_class.base64 }
    it { should have_at_least(1).chars }
  end

  describe :random_bytes do
    subject { described_class.random_bytes }
    it { should have_at_least(1).chars }
    it_behaves_like "conditional random", :random_bytes, Proc.new{|random|  random.match(/^[a-z]/) }
  end

  describe :random_number do
    subject { described_class.random_number }
    it { should > 0 }
    it_behaves_like "conditional random", :random_number, Proc.new{|random| random < 0.5 }
  end

  describe :urlsafe_base64 do
    subject { described_class.urlsafe_base64 }
    it { should have_at_least(1).chars }
    it_behaves_like "conditional random", :urlsafe_base64, Proc.new{|random| random.match(/^[a-z]/) }
  end

  describe :uuid do
    subject { described_class.uuid }
    it { should have_at_least(1).chars }
    it_behaves_like "conditional random", :uuid, Proc.new{|random| random.match(/^[a-z]/) }
  end
end
