local ffi   = require "ffi"
local C     = ffi.C;
love.native = ffi.os == "Windows" and ffi.load "love" or C

ffi.cdef [[
typedef void(*PHYSFS_StringCallback)(void *data, char const *str);
typedef void(*PHYSFS_EnumFilesCallback)(void *data, char const *origdir, char const *fname);

typedef struct PHYSFS_File
{
    void *opaque;
} PHYSFS_File;

typedef struct PHYSFS_ArchiveInfo
{
    char const *extension;
    char const *description;
    char const *author;
    char const *url;
} PHYSFS_ArchiveInfo;

typedef struct PHYSFS_Version
{
    uint8_t major;
    uint8_t minor;
    uint8_t patch;
} PHYSFS_Version;

typedef struct PHYSFS_Allocator
{
    int(*Init)(void);
    void(*Deinit)(void);
    void *(*Malloc)(uint64_t);
    void *(*Realloc)(void *, uint64_t);
    void(*Free)(void *);
} PHYSFS_Allocator;

void PHYSFS_getLinkedVersion(PHYSFS_Version *ver);
int PHYSFS_init(char const *argv0);
int PHYSFS_deinit(void);
PHYSFS_ArchiveInfo const **PHYSFS_supportedArchiveTypes(void);
void PHYSFS_freeList(void *listVar);
char const *PHYSFS_getLastError(void);
char const *PHYSFS_getDirSeparator(void);
void PHYSFS_permitSymbolicLinks(int allow);
char **PHYSFS_getCdRomDirs(void);
char const *PHYSFS_getBaseDir(void);
char const *PHYSFS_getUserDir(void);
char const *PHYSFS_getWriteDir(void);
int PHYSFS_setWriteDir(char const *newDir);
int PHYSFS_addToSearchPath(char const *newDir, int appendToPath);
int PHYSFS_removeFromSearchPath(char const *oldDir);
char **PHYSFS_getSearchPath(void);
int PHYSFS_setSaneConfig(char const *organization, char const *appName, char const *archiveExt, int includeCdRoms, int archivesFirst);
int PHYSFS_mkdir(char const *dirName);
int PHYSFS_delete(char const *filename);
char const *PHYSFS_getRealDir(char const *filename);
char **PHYSFS_enumerateFiles(char const *dir);
int PHYSFS_exists(char const *fname);
int PHYSFS_isDirectory(char const *fname);
int PHYSFS_isSymbolicLink(char const *fname);
int64_t PHYSFS_getLastModTime(char const *filename);
PHYSFS_File *PHYSFS_openWrite(char const *filename);
PHYSFS_File *PHYSFS_openAppend(char const *filename);
PHYSFS_File *PHYSFS_openRead(char const *filename);
int PHYSFS_close(PHYSFS_File *handle);
int64_t PHYSFS_read(PHYSFS_File *handle, void *buffer, uint32_t objSize, uint32_t objCount);
int64_t PHYSFS_write(PHYSFS_File *handle, void const *buffer, uint32_t objSize, uint32_t objCount);
int PHYSFS_eof(PHYSFS_File *handle);
int64_t PHYSFS_tell(PHYSFS_File *handle);
int PHYSFS_seek(PHYSFS_File *handle, uint64_t pos);
int64_t PHYSFS_fileLength(PHYSFS_File *handle);
int PHYSFS_setBuffer(PHYSFS_File *handle, uint64_t bufsize);
int PHYSFS_flush(PHYSFS_File *handle);
int16_t PHYSFS_swapSLE16(int16_t val);
uint16_t PHYSFS_swapULE16(uint16_t val);
int32_t PHYSFS_swapSLE32(int32_t val);
uint32_t PHYSFS_swapULE32(uint32_t val);
int64_t PHYSFS_swapSLE64(int64_t val);
uint64_t PHYSFS_swapULE64(uint64_t val);
int16_t PHYSFS_swapSBE16(int16_t val);
uint16_t PHYSFS_swapUBE16(uint16_t val);
int32_t PHYSFS_swapSBE32(int32_t val);
uint32_t PHYSFS_swapUBE32(uint32_t val);
int64_t PHYSFS_swapSBE64(int64_t val);
uint64_t PHYSFS_swapUBE64(uint64_t val);
int PHYSFS_readSLE16(PHYSFS_File *file, int16_t *val);
int PHYSFS_readULE16(PHYSFS_File *file, uint16_t *val);
int PHYSFS_readSLE32(PHYSFS_File *file, int32_t *val);
int PHYSFS_readULE32(PHYSFS_File *file, uint32_t *val);
int PHYSFS_readSLE64(PHYSFS_File *file, int64_t *val);
int PHYSFS_readULE64(PHYSFS_File *file, uint64_t *val);
int PHYSFS_readSBE16(PHYSFS_File *file, int16_t *val);
int PHYSFS_readUBE16(PHYSFS_File *file, uint16_t *val);
int PHYSFS_readSBE32(PHYSFS_File *file, int32_t *val);
int PHYSFS_readUBE32(PHYSFS_File *file, uint32_t *val);
int PHYSFS_readSBE64(PHYSFS_File *file, int64_t *val);
int PHYSFS_readUBE64(PHYSFS_File *file, uint64_t *val);
int PHYSFS_writeSLE16(PHYSFS_File *file, int16_t val);
int PHYSFS_writeULE16(PHYSFS_File *file, uint16_t val);
int PHYSFS_writeSLE32(PHYSFS_File *file, int32_t val);
int PHYSFS_writeULE32(PHYSFS_File *file, uint32_t val);
int PHYSFS_writeSLE64(PHYSFS_File *file, int64_t val);
int PHYSFS_writeULE64(PHYSFS_File *file, uint64_t val);
int PHYSFS_writeSBE16(PHYSFS_File *file, int16_t val);
int PHYSFS_writeUBE16(PHYSFS_File *file, uint16_t val);
int PHYSFS_writeSBE32(PHYSFS_File *file, int32_t val);
int PHYSFS_writeUBE32(PHYSFS_File *file, uint32_t val);
int PHYSFS_writeSBE64(PHYSFS_File *file, int64_t val);
int PHYSFS_writeUBE64(PHYSFS_File *file, uint64_t val);
int PHYSFS_isInit(void);
int PHYSFS_symbolicLinksPermitted(void);
int PHYSFS_setAllocator(PHYSFS_Allocator const *allocator);
int PHYSFS_mount(char const *newDir, char const *mountPoint, int appendToPath);
char const *PHYSFS_getMountPoint(char const *dir);
void PHYSFS_getCdRomDirsCallback(PHYSFS_StringCallback c, void *d);
void PHYSFS_getSearchPathCallback(PHYSFS_StringCallback c, void *d);
void PHYSFS_enumerateFilesCallback(char const *dir, PHYSFS_EnumFilesCallback c, void *d);
void PHYSFS_utf8FromUcs4(uint32_t const *src, char *dst, uint64_t len);
void PHYSFS_utf8ToUcs4(char const *src, uint32_t *dst, uint64_t len);
void PHYSFS_utf8FromUcs2(uint16_t const *src, char *dst, uint64_t len);
void PHYSFS_utf8ToUcs2(char const *src, uint16_t *dst, uint64_t len);
void PHYSFS_utf8FromLatin1(char const *src, char *dst, uint64_t len);
]]

-- Remove mount limitations
love.filesystem.mount = function(archive, mountpoint, appendToPath)
    return love.native.PHYSFS_mount(archive, mountpoint, appendToPath or false)
end
