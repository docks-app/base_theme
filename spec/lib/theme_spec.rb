require "spec_helper"

describe Docks::Themes::Base do
  subject { described_class.instance }

  let(:asset_root) { File.expand_path("../../../assets", __FILE__) }

  describe "#styles" do
    it "has all of the compiled styles" do
      expect(subject.styles).to eq Dir[File.join(asset_root, "styles/*.*")]
    end
  end

  describe "#scripts" do
    it "has all of the compiled scripts" do
      expect(subject.scripts).to eq Dir[File.join(asset_root, "scripts/*.*")]
    end
  end

  describe "#setup" do
    let(:builder) do
      double(options: OpenStruct.new(style_language: "scss", script_language: "javascript", template_language: "erb"))
    end

    it "adds style files" do
      expect(builder).to receive(:add_assets).with :styles, Dir[File.join(asset_root, "styles/scss/**/*")]
      allow(builder).to receive(:add_assets)
      subject.setup(builder)
    end

    it "adds script files" do
      expect(builder).to receive(:add_assets).with :scripts, Dir[File.join(asset_root, "scripts/javascript/**/*")]
      allow(builder).to receive(:add_assets)
      subject.setup(builder)
    end

    it "adds template files" do
      expect(builder).to receive(:add_assets).with :templates, Dir[File.join(asset_root, "templates/erb/**/*")]
      allow(builder).to receive(:add_assets)
      subject.setup(builder)
    end

    it "adds style files of a custom language" do
      builder.options.style_language = "less"
      expect(builder).to receive(:add_assets).with :styles, Dir[File.join(asset_root, "styles/less/**/*")]
      allow(builder).to receive(:add_assets)
      subject.setup(builder)
    end

    it "adds script files of a custom language" do
      builder.options.script_language = "coffeescript"
      expect(builder).to receive(:add_assets).with :scripts, Dir[File.join(asset_root, "scripts/coffeescript/**/*")]
      allow(builder).to receive(:add_assets)
      subject.setup(builder)
    end

    it "adds template files of a custom language" do
      builder.options.template_language = "haml"
      expect(builder).to receive(:add_assets).with :templates, Dir[File.join(asset_root, "templates/haml/**/*")]
      allow(builder).to receive(:add_assets)
      subject.setup(builder)
    end
  end

  describe "#configure" do
    it "has a #configure method" do
      expect(subject).to respond_to(:configure)
    end
  end
end
