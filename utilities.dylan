module: libgit2

define macro git-options-definer
  { define git-options ?type:name ?flags:* end }
    => { define git-options-aux ?type (?flags) (?flags) end }
end macro git-options-definer;

define macro git-options-aux-definer
  { define git-options-aux ?type:name (?keys) (?flags:*) end }
    => { define method initialize (?=opts :: ?type, #key ?keys)
           ?=next-method();
           gen-bindings(?flags);
         end }
keys:
  { }
    => { }
  { ?key; ... }
    => { ?key, ... }
key:
  { }
    => { }
  { option ?identifier:name => ?dylan-identifier:name ?default-value }
    => { ?dylan-identifier = ?default-value }
default-value:
  { }
    => { #f }
  { = ?val:expression }
    => { ?val }
end;

define macro gen-bindings
  { gen-bindings () }
    => { }
  { gen-bindings (?option; ?more:*) }
    => { ?option; gen-bindings(?more) }
option:
  { option ?getter:name => ?identifier:name ?:* }
    => { if (?identifier)
           ?getter ## "-setter"(?identifier, ?=opts);
         end if }
end macro;

define function strarray-to-vector (sa :: <git-strarray*>) => (v :: <vector>)
  let v = make(<vector>, size: git-strarray$count(sa));
  let strings = git-strarray$strings(sa);
  for (i from 0 below size(v))
    v[i] := strings[i];
  end for;
  v
end function strarray-to-vector;

define function sequence-to-strarray (seq :: <sequence>) => (sa :: <git-strarray*>)
  let sa = make(<git-strarray*>);
  git-strarray$count(sa) := size(seq);
  let strings = make(<C-string*>, size: size(seq));
  for (i from 0, s in seq)
    strings[i] := s;
  end for;
  git-strarray$strings(sa) := strings;
  sa
end function sequence-to-strarray;
