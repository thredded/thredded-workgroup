# frozen_string_literal: true

require 'spec_helper'


describe Thredded::AllViewHooks do

  module ViewContextStub
    module_function

    def x
      'x'
    end

    def original
      'original'
    end

    def safe_join(arr, sep)
      arr.join(sep)
    end

    def capture
      yield
    end
  end

  # <REQUIRED CHANGES> in thredded workgroup
  #
  let(:view_hooks) { described_class.new }
  it "includes original sections" do
    expect(view_hooks.public_methods(false)).to include(:post_common, :posts_common, :messageboards_index)
  end
  EXPECTED_WORKGROUP_SECTIONS = [:topic_with_last_post]
  it "includes thredded workgroup sections" do
    expect(view_hooks.public_methods).to include(*EXPECTED_WORKGROUP_SECTIONS)
  end
  it "has sections that work" do
    sections = Thredded::Workgroup::ViewHooks.public_instance_methods(false)
    expect(sections).to contain_exactly(*EXPECTED_WORKGROUP_SECTIONS)
    sections = sections.reduce({}) do |h, section_name|
      h.update(section_name => view_hooks.send(section_name).public_methods(false))
    end
    test_sections(sections)
  end

  it 'works' do
    sections = view_hooks.public_methods(false).reduce({}) do |h, section_name|
      h.update(section_name => view_hooks.send(section_name).public_methods(false))
    end

    test_sections(sections)
  end

  def test_sections(sections)
    #</REQUIRED CHANGES>
    sections.each do |section_name, hook_names|
      hook_names.each_with_index do |hook_name, i|
        # @type [Thredded::ViewHooks::Config]
        hook_config = view_hooks.send(section_name).send(hook_name).config
        hook_config.before { "#{hook_name} 1" }
        hook_config.before { 'before 2' }
        hook_config.replace { x } if i.even?
        hook_config.after { 'after 1' }
        hook_config.after { |y:| "#{x} #{y} 2" }
      end
    end

    sections.each do |section_name, hook_names|
      hook_names.each_with_index do |hook_name, i|
        result = view_hooks.send(section_name).send(hook_name).render(ViewContextStub, y: 'y') { original }
        expect(result).to(eq ["#{hook_name} 1", 'before 2', (i.even? ? 'x' : 'original'), 'after 1', 'x y 2'].join(''))
      end
    end
  end
end
