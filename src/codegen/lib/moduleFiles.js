export class ModuleFiles {
  constructor() {
    this.moduleFiles = new Set();
    this.inProgress = new Set();
  }

  add(file) {
    this.moduleFiles.add(file);
  }

  values() {
    return this.moduleFiles;
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