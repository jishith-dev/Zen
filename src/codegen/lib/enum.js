export class Enum {
  constructor(IRB) {
    this.IRB = IRB;
  }

  handleEnum(node) {

    if (this.IRB.enums.has(node.name)) {
      this.IRB.emitError(
        "EnumError",
        `Enum '${node.name}' already exists`,
        node
      );
    }

    const members = new Map();
    let nextValue = 0;

    for (const member of node.members) {
      if (members.has(member.name)) {
        this.IRB.emitError(
          "EnumError",
          `Duplicate enum member '${member.name}'`,
          member
        );
      }

      let value;

      if (member.value) {
        value = Number(member.value.value);

        if (Number.isNaN(value)) {
          this.IRB.emitError(
            "EnumError",
            `Enum value for '${member.name}' must be a constant integer`,
            member
          );
        }

        nextValue = value + 1;
      } else {
        value = nextValue++;
      }

      members.set(member.name, value);
    }

    this.IRB.enums.set(node.name, {
      type: "enum",
      name: node.name,
      members
    });
  }
}