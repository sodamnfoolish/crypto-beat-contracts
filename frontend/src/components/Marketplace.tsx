import React, { useState } from "react";
import { useIPFS } from "../hooks/IPFS";

export default function Marketplace() {
  const [file, setFile] = useState(null as any);
  const [fileUrl, setFileUrl] = useState("");

  const { client, fileNameAndCIDToUrl } = useIPFS();

  const onInputChange = (e: any) => setFile(e.target.files[0]);

  const onUploadButtonClick = async () => {
    try {
      const added = await client.add(file);
      setFileUrl(fileNameAndCIDToUrl(file.name, added.path));
    } catch (error) {
      console.log(error);
    }
  };

  const onDownloadButtonClick = async () => {
    window.open(fileUrl, "_blank", "noopener,noreferrer");
  };

  return (
    <div>
      <div>
        <input type="file" onChange={onInputChange} />
      </div>
      <div>
        <button disabled={file == null} onClick={onUploadButtonClick}>
          Upload to IPFS
        </button>
      </div>
      <div>
        <button disabled={fileUrl == ""} onClick={onDownloadButtonClick}>
          Download
        </button>
      </div>
    </div>
  );
}
