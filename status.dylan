module: libgit2
synopsis: status related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define git-options <git-status-options*>
  option git-status-options$version => version = 1;
  option git-status-options$show => show;
  option git-status-options$flags => flags;
  option git-status-options$pathspec => pathspec;
end git-options;

define method size (statuses :: <git-status-list*>) => (size :: <integer>)
  git-status-list-entrycount(statuses)
end method size;

define method element
    (status-list :: <git-status-list*>, key :: <integer>, #key default = $unsupplied)
 => (element :: <object>)
  if (key < size(status-list))
    git-status-by-index(status-list, key)
  elseif (default = $unsupplied)
    error("Attempt to access key %= which is outside of %=.", key, status-list)
  else
    default
  end if
end method element;

define method forward-iteration-protocol
    (status-list :: <git-status-list*>)
 => (initial-state :: <integer>, limit :: <integer>,
     next-state :: <function>, finished-state? :: <function>,
     current-key :: <function>, current-element :: <function>,
     current-element-setter :: <function>, copy-state :: <function>)
  values(
    // initial-state
    0,
    // limit
    size(status-list),
    // next-state
    method (status-list :: <git-status-list*>, state :: <integer>)
      state + 1
    end,
    // finished-state?
    method (status-list :: <git-status-list*>, state :: <integer>, limit :: <integer>)
      state = limit
    end,
    // current-key
    method (status-list :: <git-status-list*>, state :: <integer>)
      state
    end,
    // current-element
    element,
    // current-element-setter
    method (value, status-list :: <git-status-list*>, state :: <integer>)
      error("Setting an element of a git-status-list is not allowed.")
    end,
    // copy-state
    identity)
end method forward-iteration-protocol;
