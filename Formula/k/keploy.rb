class Keploy < Formula
  desc "Testing Toolkit creates test-cases and data mocks from API calls, DB queries"
  homepage "https://keploy.io"
  url "https://github.com/keploy/keploy/archive/refs/tags/v2.6.7.tar.gz"
  sha256 "6a00509c43648aec8f23d68ff7c3c8409bc8ff33ce86627fa40688a204c0d9c1"
  license "Apache-2.0"
  head "https://github.com/keploy/keploy.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6ff5e080f6791fc2d5cbf50daf0ce83e9240e15f572f31361c53c4d6196a6e7f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6ff5e080f6791fc2d5cbf50daf0ce83e9240e15f572f31361c53c4d6196a6e7f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6ff5e080f6791fc2d5cbf50daf0ce83e9240e15f572f31361c53c4d6196a6e7f"
    sha256 cellar: :any_skip_relocation, sonoma:        "4e14c97a44dac66c3bbc7a9981a6c97f268d64418ddf8cfa8d46bf218e0211d6"
    sha256 cellar: :any_skip_relocation, ventura:       "4e14c97a44dac66c3bbc7a9981a6c97f268d64418ddf8cfa8d46bf218e0211d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae6e9913f7cb121e5d0db05ef640198c6b31121d230eb648774dabaa3728e947"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
  end

  test do
    system bin/"keploy", "config", "--generate", "--path", testpath
    assert_match "# Generated by Keploy", (testpath/"keploy.yml").read

    output = shell_output("#{bin}/keploy templatize --path #{testpath}")
    assert_match "No test sets found to templatize", output

    assert_match version.to_s, shell_output("#{bin}/keploy --version")
  end
end
