# Line Endings Decision

## 2024-12-19 - Git Line Ending Configuration

**Context**: Git was showing CRLF/LF conversion warnings on Windows
**Problem**: Auto-conversion can break shell scripts, Docker, Terraform, and CI/CD tools

**Options**:
- Keep Git's autocrlf=true (convert to CRLF on Windows)
- Use autocrlf=false with LF everywhere
- Mixed approach with .gitattributes

**Decision**: LF line endings everywhere
**Reason**: 
- **Tool compatibility**: Shell scripts, Docker, Terraform need LF
- **Cross-platform**: Works on all systems
- **Modern standard**: Industry best practice
- **No conversion issues**: Consistent across environments

**Implementation**:
- `git config core.autocrlf false` - Disable auto-conversion
- `git config core.eol lf` - Use LF line endings
- `.gitattributes` - Enforce LF for all text files
- `git add --renormalize .` - Convert existing files to LF

**Impact**: 
- All files now use LF endings consistently
- No more Git line ending warnings
- Shell scripts and tools will work correctly
- Deployment to Linux/containers will be seamless