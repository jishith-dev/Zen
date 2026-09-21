// compiler global state instance

export class ModuleFiles {
  constructor() {
    this.moduleFiles = new Set();
    this.inProgress = new Set();
    this.defFunctions = new Map();
    this.declFunctions = new Map();
    this.nativeFiles = new Set();
    this.flags = new Set();
    this.baseDir = null;
    this.source = "";
    this.currentModuleName = "";
  }

  add(file) {
    this.moduleFiles.add(file);
  }

  addFlag(flag) {
    this.flags.add(flag);
  }

  values() {
    return this.moduleFiles;
  }

  addNative(file) {
    this.nativeFiles.add(file);
  }

  startCompiling(source, fileContent) {
    this.inProgress.add(source);
    this.source = fileContent;
    this.currentModuleName = source;
  }

  finishCompiling(source) {
    this.inProgress.delete(source);
    this.source = "";
    this.currentModuleName = "";
  }

  isCompiling(source) {
    return this.inProgress.has(source);
  }

  getCurrentCompilingSource() {
    return this.source;
  }
}
