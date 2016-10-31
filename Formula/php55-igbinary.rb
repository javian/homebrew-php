require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Igbinary < AbstractPhp55Extension
  init
  desc "Igbinary is a drop in replacement for the standard php serializer."
  homepage "https://pecl.php.net/package/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.1.tar.gz"
  sha256 "9c66e6bb8225bf559148661d8ef81451e5f67f0a565d975dc0918abd8c35e0ed"
  head "https://github.com/igbinary/igbinary.git"

  depends_on "igbinary" => :build

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "2589cd89f5789e1ce76a50eb833624ff6cda9440baeada4f0b4dba33d289f2df" => :el_capitan
    sha256 "9013243cb1f48f03789397481a5949290b91689947827046a526adbef50d16be" => :yosemite
    sha256 "798945add8f635785dc9b15075d6b76917dc6e2b1e24ade1acbe81fe4b743163" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    rm "apc_serializer.h"
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/igbinary.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
      ; Enable or disable compacting of duplicate strings
      ; The default is On.
      ;igbinary.compact_strings=On

      ; Use igbinary as session serializer
      ;session.serialize_handler=igbinary

      ; Use igbinary as APC serializer
      ;apc.serializer=igbinary
    EOS
  end
end
