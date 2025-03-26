{ config, pkgs, inputs, ... }:
{
  config = {
    programs = {
	nushell = { enable = true;
	  extraConfig = ''
	   let carapace_completer = {|spans|
	   carapace $spans.0 nushell ...$spans | from json
	   }
	   $env.config = {
	    show_banner: false,
	    completions: {
	      case_sensitive: false # case-sensitive completions
	      quick: true    # set to false to prevent auto-selecting completions
	      partial: true    # set to false to prevent partial filling of the prompt
	      algorithm: "fuzzy"    # prefix or fuzzy
	      external: {
	      # set to false to prevent nushell looking into $env.PATH to find more suggestions
		  enable: true 
	      # set to lower can improve completion performance at the cost of omitting some options
		  max_results: 100 
		  completer: $carapace_completer # check 'carapace_completer' 
	      }
	    }
	   } 
	   $env.PATH = ($env.PATH | 
	   split row (char esep) |
	   prepend /home/myuser/.apps |
	   append /usr/bin/env
	   )
	   '';
	   shellAliases = {
	    vi = "nvim";
	    vim = "nvim";
	    nano = "nvim";

	    ls="ls -la";

	    #git aliases
	    gs="git status";
	    ga="git add";
	    gc="git commit -m";
	    gch="git checkout";

	    #Handy list ec2 command
	    ec2="aws ec2 describe-instances --query \"Reservations[*].Instances[*].{Instance:InstanceId,Instance:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value}\" --filters \"Name=tag:Application,Values=*\" --output table --region=us-east-2";

	    # Wright20 repo navicagations
	    w="tmux a -t wright";
	    api="~/wright/wright-20-api/";
	    ams="~/wright/auction-system/";
	    sms="~/wright/wright20-sms";
	    app="~/wright/wright-20-app";
	    models="~/wright/wright20-models";
	    cas="~/wright/CAS";
	    util="~/wright/utility-server";
	    cms="~/wright/wright-20-cms";
	    helpers="~/wright/wright-20-helpers";
	    migrations="~/wright/migrations";
	    devd="~/wright/dev-diary";
	   };
       };  
       carapace.enable = true;
       carapace.enableNushellIntegration = true;

       starship = { enable = true;
	   settings = {
	     add_newline = true;
	     character = { 
	     success_symbol = "[➜](bold green)";
	     error_symbol = "[➜](bold red)";
	   };
	};
      };
    };

  };
}
