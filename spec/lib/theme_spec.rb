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

  describe "#helpers" do
    it "has no helpers" do
      expect(subject.helpers).to be_empty
    end
  end

  describe "#setup" do
    let(:builder) do
      double(options: OpenStruct.new(style_language: "scss", script_language: "javascript", template_language: "erb"))
    end

    before(:each) do
      allow(builder).to receive(:add_assets)
    end

    it "adds style files" do
      subject.setup(builder)
      expect(builder).to have_received(:add_assets).with Dir[File.join(asset_root, "styles/scss/**/*.*")], type: :styles, root: Pathname.new(File.join(asset_root, "styles/scss"))
    end

    it "adds script files" do
      subject.setup(builder)
      expect(builder).to have_received(:add_assets).with Dir[File.join(asset_root, "scripts/javascript/**/*.*")], type: :scripts, root: Pathname.new(File.join(asset_root, "scripts/javascript"))
    end

    it "adds template files" do
      subject.setup(builder)
      expect(builder).to have_received(:add_assets).with Dir[File.join(asset_root, "templates/erb/**/*.*")], type: :templates, root: Pathname.new(File.join(asset_root, "templates/erb"))
    end

    it "adds style files of a custom language" do
      builder.options.style_language = "less"
      subject.setup(builder)
      expect(builder).to have_received(:add_assets).with Dir[File.join(asset_root, "styles/less/**/*.*")], type: :styles, root: Pathname.new(File.join(asset_root, "styles/less"))
    end

    it "adds script files of a custom language" do
      builder.options.script_language = "coffeescript"
      subject.setup(builder)
      expect(builder).to have_received(:add_assets).with Dir[File.join(asset_root, "scripts/coffeescript/**/*.*")], type: :scripts, root: Pathname.new(File.join(asset_root, "scripts/coffeescript"))
    end

    it "adds template files of a custom language" do
      builder.options.template_language = "haml"
      subject.setup(builder)
      expect(builder).to have_received(:add_assets).with Dir[File.join(asset_root, "templates/haml/**/*.*")], type: :templates, root: Pathname.new(File.join(asset_root, "templates/haml"))
    end
  end

  describe "#configure" do
    it "has a #configure method" do
      expect(subject).to respond_to(:configure)
    end
  end
end
