import React, { useState, useEffect } from "react";
import axios from "axios";
import { Table } from "antd";
const ApiUrl = `https://jsonplaceholder.typicode.com`;

export default function App() {
  const [posts, setPosts] = useState([]);

  const fetchPostAll = async () => {
    try {
      const { data, status } = await axios.get(`${ApiUrl}/posts`);
      if (status === 200) {
        // console.log("data", data);
        setPosts(data);
      }
    } catch (error) {
      console.error("fetching error!...", error);
    }
  };

  const columns = [
    {
      title: "Id",
      dataIndex: "id",
      key: "id",
    },
    {
      title: "UserId",
      dataIndex: "userId",
      key: "userId",
    },
    {
      title: "Title",
      dataIndex: "title",
      key: "title",
    },
  ];

  useEffect(() => {
    // return () => {
    fetchPostAll();
    // };
  }, []);

  return (
    <>
      <Table dataSource={posts} columns={columns} />;
    </>
  );
}
