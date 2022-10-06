import {
  ApolloClient,
  InMemoryCache,
  ApolloProvider,
  gql,
} from "@apollo/client";

export function useSubGraph() {
  const client = new ApolloClient({
    uri: process.env.REACT_APP_SUBGRAPH_URL,
    cache: new InMemoryCache(),
  });

  const getBeatsOnSale = async () => {
    client.query({
      query: gql`
        query getBeatsOnSale {
          onSaleCryptoBeats(where: { onSale: true }) {
            id
            onSale
            seller
            sellTimestamp
            buyer
            buyTimestamp
            cryptoBeatId
            cryptoBeatPrice
          }
        }
      `,
    });
  };
}
