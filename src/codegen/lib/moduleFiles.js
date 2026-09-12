// compiler global state instance

export class ModuleFiles {
  constructor() {
    this.moduleFiles = new Set();
    this.inProgress = new Set();
    this.defFunctions = new Map();
    this.declFunctions = new Map();
    this.nativeFiles = new Set();
  }

  add(file) {
    this.moduleFiles.add(file);
  }

  values() {
    return this.moduleFiles;
  }

  addNative(file) {
  this.nativeFiles.add(file);
  }

  startCompiling(source) {
    this.inProgress.add(source);
  }

  finishCompiling(source) {
    this.inProgress.delete(source);
  }

  isCompiling(source) {
    return this.inProgress.has(source);
  }
}
