require "optparse"
require "fileutils"

DEFAULT_TARGETS = [
  "git",
  "tmux",
  "vi",
  "zsh"
]

@options = {}
OptionParser.new do |opts|
  opts.banner = "Deploy/update configuration files"

  opts.on("-d", "--dir DIRNAME", String,
          "Directory name to deploy (default: #{ENV["HOME"]}") do |dir|
    @options[:dir] = dir
  end
  @options[:dir] ||= ENV["HOME"]

  msg = ["Target configuration"]
  msg += DEFAULT_TARGETS.map { |t| "  - ${t}" }
  opts.on("-t", "--target TARGETS", Array, *msg) do |tgt|
    @options[:target] = tgt
  end
  @options[:target] ||= "all"
end.parse!

def cmd_str
  system(*%W(#{cmd_str}), out: $stdout, err: out)
end

def mkdir dirname
  unless File.exist?(dirname)
    FileUtils.mkdir_p(dirname)
  end
end

def ln_s src, dst
  unless File.exist?(dst)
    FileUtils.ln_s(src, dst)
  end
end

def to_dot_file src, dir = @options[:dir]
  return File.join(dir, "." + File.basename(src))
end

def deploy src, dst, more: nil, copy: false
  src = Array(src)
  dst = Array(dst)

  src.zip(dst) do |s, d|
    if copy
      FileUtils.cp(s, d)
    else
      ln_s(s, d)
    end
  end

  more&.each {|m| send(m)}
end

def deploy_git
  print("\nDeploying git configuration files...")
  src_dir = File.join(__dir__, "git")

  src = [
    File.join(src_dir, "gitconfig"),
    File.join(src_dir, "gitignore"),
  ]
  dst = src.map {|s| to_dot_file(s)}

  deploy(src, dst)
end

def deploy_tmux
  print("\nDeploying git configuration files...")

  src = [ File.join(__dir__, "tmux.conf") ]
  dst = src.map {|s| to_dot_file(s) }

  deploy(src, dst)
end

def deploy_vi
  print("\nDeploying vi configuration files...")
  plugin_dir = File.join(__dir__, "vim-plugins")
  dein_dir = File.join(@options[:dir], ".vim", "dein")

  mkdir(dein_dir)

  src = [
    File.join(plugin_dir, "tanahiro", "vimrc"),
    File.join(plugin_dir, "tanahiro", "gvimrc")
  ]
  dst = src.map {|s| to_dot_file(s)}

  src << plugin_dir
  dst << File.join(dein_dir, "repos")

  deploy(src, dst)
end

def deploy_zsh
  print("\nDeploying zsh configuration files...")
  zsh_dir = File.join(__dir__, "zsh")

  mkdir(File.join(@options[:dir], ".zsh"))

  src = [
    File.join(zsh_dir, "zshrc"),
    File.join(zsh_dir, "zshenv")
  ]

  dst = src.map {|s| to_dot_file(s)}

  src << File.join(__dir__, "dircolors-solarized", "dircolors.ansi-light")
  dst << File.join(@options[:dir], ".dir_colors")

  src << File.join(__dir__, "zsh", "ohmyzsh")
  dst << File.join(@options[:dir], ".zsh", "ohmyzsh")

  deploy(src, dst)
end

def execute target
  method_name = ("deploy_" + target).to_sym
  send(method_name)
end

def main
  puts("Home dir: #{@options[:dir]}")

  if @options[:target] == "all"
    DEFAULT_TARGETS.each do |target|
      execute(target)
    end
  else
    unless @options[:target].is_a?(Array)
      @options[:target] = [@options[:target]]
    end

    @options[:target].each do |target|
      if DEFAULT_TARGTES>includ?(target)
        execute(target)
      else
        raise RuntimeError, "Unknown target: #{target}"
      end
    end
  end

  print("\n")
end

main()
