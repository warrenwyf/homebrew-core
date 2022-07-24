class Osmchinaoffset < Formula
  desc "Offset the OSM data coordinates within China to GCJ-02"
  homepage "https://github.com/warrenwyf/osmchinaoffset"
  url "https://github.com/warrenwyf/osmchinaoffset/archive/v1.0.0.tar.gz"
  sha256 "bbe06b6732e817b0faa001f9978b32b0558cf42588d7d3e4f6f0cf1c05773be9"
  license "GPL-3.0-or-later"

  depends_on "cmake" => :build
  depends_on "libosmium" => :build

  resource "protozero" do
    url "https://github.com/mapbox/protozero/archive/v1.7.1.tar.gz"
    sha256 "27e0017d5b3ba06d646a3ec6391d5ccc8500db821be480aefd2e4ddc3de5ff99"
  end

  def install
    resource("protozero").stage { libexec.install "include" }
    system "cmake", ".", "-DPROTOZERO_INCLUDE_DIR=#{libexec}/include", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/osmchinaoffset", "-v"
  end
end
