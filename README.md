# `sgit`

This is a tool for managing git configuration easily

## Table of contents
  * [Table of contents](#table-of-contents)
  * [Installation](#installation)
    * [Manual installation](#manual-installation)
  * [Usage](#usage)
    * [Shortcuts for common commands](#shortcuts-for-common-commands)
    * [sgit configuration tool](#sgit-configuration-tool)
      * [One-time configuration](#one-time-configuration)
      * [Generic configuration](#generic-configuration)
      * [Alias configuration](#alias-configuration)
        * [Supported aliases](#supported-aliases)
  * [Contributions and Development](#contributions-and-development) 

## Installation

### Manual installation

Follow these steps to install `sgit` manually:
1. clone this repository
2. add `<cloned directory>/scripts` directory to your `$PATH`

    Assuming that this repository cloned into `/usr/local/bin/sgit/` directory:
    
    `export PATH=$PATH:/usr/local/bin/sgit/scripts`

## Usage

<details>
 <summary>Common usage</summary>
<p>

    $sgit [COMMAND] [ARGUMENT VALUE]... [OPTION]...

1. Help

    `$sgit --help`
    
    ```
    Usage: sgit <command> [ARGUMENT VALUE]... [OPTION]...
    
    Global options:
            -h, --help                      print usage
            -v, --verbose                   verbose mode
            -q, --quiet                     only errors are printed
            --silent                        all messages are disabled
    
    Available commands:
            list                            prints lists of different objects(tools, git aliases)
            configure                       configures git aliases, username, email, etc.
            Execute 'sgit <command> --help' for more information about a command
    ```

</p>
</details>

### Shortcuts for common commands

| Shortcut   | Command                    | Description |
| ---------- | -------------------------- | ----------- |
| `sgit-s`   | `git status`               |             |    
| `sgit-pr`  | `git pull --rebase`        |             | 

### sgit configuration tool

#### One-time configuration

To configure git username, email, default editor and pre-defined aliases:

    $sgit configure --username "Your Name" --email "Your Email" --editor vim
    
This command results into:
    
    [core]
        editor = vim
    ...
    [user]
            name = Your Name
            email = Your Email
    [alias]
            s = status
            pr = pull --rebase
            c = commit
            cp = commit --amend
            cpn = commit --amend --no-edit
            ...
    ...

#### Generic configuration
1. Configure username:

    `$sgit configure --username "<Your Name>"`
    
    `$sgit configure -u "<Your Name>"`
    
2. Configure email:

    `$sgit configure --email "<Your Email>"`
    
    `$sgit configure -e "<Your Email>"`
    
  Multiple options can be applied simultaneously:

   `$sgit configure -u "<Your Name>" -e "<Your Email>" --editor "vim"`

#### Alias configuration
1. Configure all supported aliases:

    `$sgit configure`
    

##### Supported aliases

<details>
 <summary>Expand</summary>
<p>

(More will be added later)

| Alias      | Command                    | Description |
| ---------- | -------------------------- | ----------- |
| `s`        | `status`                   |             |
| `pr`       | `pull --rebase`            |             |
| `c`        | `commit`                   |             |
| `cp`       | `commit --amend`           | Amend previous commit            |
| `cpn`      | `commit --amend --no-edit` | Amend previous commit without editing the commit message |
| `ch`       | `checkout`                 |             |
| `f`        | `fetch`                    |             |
| `m`        | `merge`                    |             |
| `aa`       | `add --all`                | Add all changed files |
| `ac`       | `add .`                    | Add current directory to staged area |
| `sr`       | `reset HEAD`               |             |
| `sr1`      | `reset HEAD~1`             |             |
| `sr2`      | `reset HEAD~2`             |             |
| `hr`       | `reset --hard HEAD`        |             |
| `hr1`      | `reset --hard HEAD~1`      |             |
| `hr2`      | `reset --hard HEAD~2`      |             |
| `l`        | `log`                      |             |
| `l1`       | `log -1`                   |             |
| `l2`       | `log -2`                   |             |
| `l3`       | `log -3`                   |             |
| `l4`       | `log -4`                   |             |
| `l5`       | `log -5`                   |             |

</p>
</details>

#### Commands
1. List all pre-defined aliases:

    `$sgit list --aliases`
    
<details>
 <summary>Result of the command</summary>
<p>

    Aliases...
    ----------
    s=status
    pr=pull --rebase
    c=commit
    cp=commit --amend
    cpn=commit --amend --no-edit
    ch=checkout
    f=fetch
    m=merge
    aa=add --all
    ac=add .
    sr=reset HEAD
    sr1=reset HEAD~1
    sr2=reset HEAD~2
    hr=reset --hard HEAD
    hr1=reset --hard HEAD~1
    hr2=reset --hard HEAD~2
    l=log
    l1=log -1
    l2=log -2
    l3=log -3
    l4=log -4
    l5=log -5

</p>
</details>

2. List commands

    `$sgit list --commands`
    
<details>
 <summary>Result of the command</summary>
<p>

    Commands...
    -----------
    list
    configure
    
    Execute 'sgit <command> --help' for details
    
</p>
</details>

## Contributions and Development

### Contribution

1. Create an issue (what you want to see in this tool)
2. Assign any issue to yourself
3. Create a pull request

### Development

What suites you best :)