require "spec_helper"

describe Docks::Themes::Assets do
  let(:root) { File.expand_path("../../fixtures/assets", __FILE__) }
  let(:source_root) { File.expand_path("../source", root) }

  subject { described_class.new(root: root, source_root: source_root) }

  describe ".path_for" do
    around do |example|
      FileUtils.mkdir_p(source_root)
      example.run
      FileUtils.rm_rf(source_root)
    end

    it "returns a pathname object for the passed asset" do
      path = subject.path_for("styles/pattern-library.css")
      expect(path).to be_a Pathname
      expect(path).to eq Pathname.new(File.join(root, "styles/pattern-library.css"))
    end

    it "returns a pathname for a directory" do
      path = subject.path_for("styles")
      expect(path).to eq Pathname.new(File.join(root, "styles"))
    end

    it "joins parts of the file that were passed" do
      path = subject.path_for("styles", "pattern-library.css")
      expect(path).to eq Pathname.new(File.join(root, "styles/pattern-library.css"))
    end

    it "throws when the requested file does not exist" do
      expect { subject.path_for("foo/bar.js") }.to raise_error(Docks::NoAssetError)
    end

    it "provides links to source assets" do
      expected = File.expand_path("components/avatar.scss", source_root)
      FileUtils.mkdir_p(File.dirname(expected))
      FileUtils.touch(expected)
      expect(subject.path_for("components", "avatar.scss")).to eq Pathname.new File.expand_path("components/avatar.scss", source_root)
    end
  end

  describe ".files_for" do
    it "returns the list of files matching the path" do
      expect(subject.files_for("styles/**/*")).to eq Dir[File.join(root, "styles/**/*")]
    end
  end

  describe ".scripts" do
    it "returns all compiled scripts" do
      compiled_scripts = Dir[File.expand_path("scripts/*.js", root)]
      expect(compiled_scripts).not_to be_empty
      expect(subject.scripts).to eq compiled_scripts
    end
  end

  describe ".styles" do
    it "returns all compiled styles" do
      compiled_styles = Dir[File.expand_path("styles/*.css", root)]
      expect(compiled_styles).not_to be_empty
      expect(subject.styles).to eq compiled_styles
    end
  end
end
