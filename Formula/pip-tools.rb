class PipTools < Formula
  include Language::Python::Virtualenv

  desc "Locking and sync for Pip requirements files"
  homepage "https://pip-tools.readthedocs.io"
  url "https://files.pythonhosted.org/packages/b6/1b/f639642e8a9d00e46b4241ace3e93932ba7dfed8edfb55559661e2b79cb2/pip-tools-6.5.0.tar.gz"
  sha256 "d14ea4fc2c118db2a6af65a4345a8b9b355e792aedad6bf64dd3eb97c5fc5fee"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b47371326f06f1c9598058df4212dfd803e5969efdeeed0c7cb9e1fa39146eaa"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f14ebaa026ffc43f0dbf5b039c205ba96bb957a912346d80451ff74bbe1b538e"
    sha256 cellar: :any_skip_relocation, monterey:       "385978df36d819bfca87b9993a3cb9c17fd8922d9afcaade05eac0c948333a49"
    sha256 cellar: :any_skip_relocation, big_sur:        "d40c9ae044aed7106dd09fbb0095d7f9bcb872e07872a431aca58f108827b653"
    sha256 cellar: :any_skip_relocation, catalina:       "7de1775230fc40a2e4b266b8918d048fa825f09f6cf0c60fd9312aacd89d28e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b957574f88e386d443f05c3e5aae8c5b22d87b595d6357deb38196cbe9bd4995"
  end

  depends_on "python@3.10"

  resource "click" do
    url "https://files.pythonhosted.org/packages/f4/09/ad003f1e3428017d1c3da4ccc9547591703ffea548626f47ec74509c5824/click-8.0.3.tar.gz"
    sha256 "410e932b050f5eed773c4cda94de75971c89cdb3155a72a0831139a79e5ecb5b"
  end

  resource "pep517" do
    url "https://files.pythonhosted.org/packages/0a/65/6e656d49c679136edfba25f25791f45ffe1ea4ae2ec1c59fe9c35e061cd1/pep517-0.12.0.tar.gz"
    sha256 "931378d93d11b298cf511dd634cf5ea4cb249a28ef84160b3247ee9afb4e8ab0"
  end

  resource "tomli" do
    url "https://files.pythonhosted.org/packages/3d/6e/d290c9bf16159f02b70c432386aa5bfe22c2857ff460591912fd907b61f6/tomli-2.0.0.tar.gz"
    sha256 "c292c34f58502a1eb2bbb9f5bbc9a5ebc37bee10ffb8c2d6bbdfa8eb13cc14e1"
  end

  resource "wheel" do
    url "https://files.pythonhosted.org/packages/c0/6c/9f840c2e55b67b90745af06a540964b73589256cb10cc10057c87ac78fc2/wheel-0.37.1.tar.gz"
    sha256 "e9a504e793efbca1b8e0e9cb979a249cf4a0a7b5b8c9e8b65a5e39d49529c1c4"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"requirements.in").write <<~EOS
      pip-tools
      typing-extensions
    EOS

    compiled = shell_output("#{bin}/pip-compile requirements.in -q -o -")
    assert_match "This file is autogenerated by pip-compile", compiled
    assert_match "# via pip-tools", compiled
  end
end
