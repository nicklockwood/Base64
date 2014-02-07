Version 1.2

- Updated code to use native iOS and Mac OS Base64 coding methods internally. This should improve performance slightly, but has no effect on behaviour.
- Now complies with -Weverything warning level

Version 1.1

- Base64 now requires ARC (see README for details)
- Combined seperate categories into a single file for convenience
- Fixed potential crash due to calling realloc with a size of zero

Version 1.0.2

- Fixed analyser warning.

Version 1.0.1

- Added base64DecodedString and base64DecodedData convenience methods.
- Fixed analyser warning.

Version 1.0

- Initial release.