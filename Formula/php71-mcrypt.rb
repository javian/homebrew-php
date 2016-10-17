require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    rebuild 1
    sha256 "6c8f5665fd605ed72c7dec8fe855dccac97bc6c9ee6c487d8784c56008a74e26" => :sierra
    sha256 "e34a35693b30ec720dddb641984fc24e92a94450ed34cecfd0d76fa37999260e" => :el_capitan
    sha256 "d6bec3498fe3a4fc6d3833508f37333378b770945b5f321d444e6b873a603220" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  depends_on "mcrypt"
  depends_on "libtool"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
