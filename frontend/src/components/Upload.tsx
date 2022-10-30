import React from "react";
import { useContracts } from "../hooks/Contracts";
import { useIPFS } from "../hooks/IPFS";

export default function Upload(props: any) {
  const [file, setFile] = React.useState(null as any);

  const { cryptoBeat } = useContracts();

  const { client, CIDAndFileNameToURISuffix } = useIPFS();

  const onFileChange = (event: any) => setFile(event.target.files[0]);

  const onUploadButtonClick = async () => {
    const addedFile = await client.add(file);
    await (
      await cryptoBeat.mint(
        CIDAndFileNameToURISuffix(addedFile.path, file.name)
      )
    ).wait();
  };

  return (
    <div>
      <input type="file" onChange={onFileChange} />
      <button disabled={file == null} onClick={onUploadButtonClick}>
        Upload
      </button>
    </div>
  );
}
