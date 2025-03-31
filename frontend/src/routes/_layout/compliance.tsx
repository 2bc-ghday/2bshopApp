import AddCompliance from "@/components/Compliance/AddCompliance";
import { useQuery } from "@tanstack/react-query"
import { ComplianceService } from "@/client"
import {
    Container,
    EmptyState,
    Heading,
    Table,
    VStack,
  } from "@chakra-ui/react"
import { FiSearch } from "react-icons/fi"
import PendingItems from "@/components/Pending/PendingItems"
import { createFileRoute } from "@tanstack/react-router"

function ComplianceTable() {
  const { data, isLoading, isPlaceholderData } = useQuery({
    queryFn: ComplianceService.getCompliances,
    queryKey: ["compliances"],
    placeholderData: (prevData) => prevData,
  });

  console.log("API Response:", data);

  const compliances = data?.data ?? [];

  if (isLoading) {
    return <PendingItems />;
  }

  if (compliances.length === 0) {
    return (
      <EmptyState.Root>
        <EmptyState.Content>
          <EmptyState.Indicator>
            <FiSearch />
          </EmptyState.Indicator>
          <VStack textAlign="center">
            <EmptyState.Title>No compliances found</EmptyState.Title>
            <EmptyState.Description>
              Add a new compliance to get started
            </EmptyState.Description>
          </VStack>
        </EmptyState.Content>
      </EmptyState.Root>
    );
  }

  return (
    <Table.Root size={{ base: "sm", md: "md" }}>
      <Table.Header>
        <Table.Row>
          <Table.ColumnHeader>ID</Table.ColumnHeader>
          <Table.ColumnHeader>Name</Table.ColumnHeader>
        </Table.Row>
      </Table.Header>
      <Table.Body>
        {compliances.map((compliance) => (
          <Table.Row key={compliance.id} opacity={isPlaceholderData ? 0.5 : 1}>
            <Table.Cell>{compliance.id}</Table.Cell>
            <Table.Cell>{compliance.name}</Table.Cell>
          </Table.Row>
        ))}
      </Table.Body>
    </Table.Root>
  );
}

function Compliance() {
  return (
    <Container maxW="full">
      <Heading size="lg" pt={12}>
        Compliance Management
      </Heading>
      <AddCompliance />
      <ComplianceTable />
    </Container>
  );
}

export const Route = createFileRoute("/_layout/compliance")({
  component: Compliance,
})

export default Compliance;