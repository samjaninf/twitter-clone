import React, { Component } from 'react';
import { Collection, CollectionItem } from 'react-materialize';

class TweetBox extends Component {
  constructor(props) {
    super(props);

    this.state = { text: '' };
  }

  render() {
    return (
      <Collection>
        <CollectionItem href='#'>1</CollectionItem>
        <CollectionItem href='#'>2</CollectionItem>
        <CollectionItem href='#'>3</CollectionItem>
        <CollectionItem href='#'>4</CollectionItem>
      </Collection>
    );
  }
}

export default TweetBox;
