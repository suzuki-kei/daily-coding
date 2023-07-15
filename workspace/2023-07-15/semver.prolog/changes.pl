
%
% MAJOR version when you make incompatible API changes
% MINOR version when you add functionality in a backward compatible manner
% PATCH version when you make backward compatible bug fixes
%
% incompatible_change
% compatible_add
% compatible_fix
%

%ChangeSet = [
%    compatible_fix("不具合 A を修正"),
%    compatible_fix("不具合 B を修正"),
%    compatible_add("新機能 C を追加"),
%    incompatible_change("既存機能の D を変更")
%].
%
%hoge :-
%    writeln(ChangeSet).

%semver_maximum_change_impact(MaximumImpact, ChangeSet)
%
%semver_bumped_version(Version, Version, []).
%
%semver_bumped_version(BumpedVersion, Version, ChangeSet) :-
%    ...

