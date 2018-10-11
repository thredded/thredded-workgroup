# frozen_string_literal: true

require "spec_helper"

describe Thredded::Workgroup do
  it "has a version number" do
    expect(Thredded::Workgroup::VERSION).not_to be nil
  end
end
